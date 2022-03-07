codeunit 50108 "Vendor Mgt"
{
    var
        AuthorityTxt: Label 'https://login.microsoftonline.com/{AadTenantId}/oauth2/v2.0/token';
        BCBaseUrlTxt: Label 'https://api.businesscentral.dynamics.com/v2.0/{BCEnvironmentName}/api/v2.0/companies({BCCompanyId})';
        AccessToken: Text;
        AccesTokenExpires: DateTime;

    trigger OnRun()
    var
        OAuthSetup: Record "OAuth Setup";
        Vendors: Text;
    begin
        if OAuthSetup.Get() then
            Vendors := CallBusinessCentralAPI(OAuthSetup."BC Environment Name", OAuthSetup."BC Company ID", 'vendors');
    end;

    procedure CallBusinessCentralAPI(BCEnvironmentName: Text; BCCompanyId: Text; Resource: Text) Result: Text
    var
        CustomVendorTable: Record "Vendor Table";
        OAuthSetup: Record "OAuth Setup";
        Client: HttpClient;
        Response: HttpResponseMessage;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        Url: Text;
        LineNo: Integer;
    begin

        //if (AccessToken = '') or (AccesTokenExpires = 0DT) or (AccesTokenExpires > CurrentDateTime) then
        CheckAccessToken();
        if OAuthSetup.Get() then begin
            //GetAccessToken(OAuthSetup."Tenant ID");
            Client.DefaultRequestHeaders.Add('Authorization', GetAuthenticationHeaderValue(OAuthSetup.Token));
            Client.DefaultRequestHeaders.Add('Accept', 'application/json');
            Url := GetBCAPIUrl(BCEnvironmentName, BCCompanyId, Resource);
            if not Client.Get(Url, Response) then
                if Response.IsBlockedByEnvironment then
                    Error('Request was blocked by environment')
                else
                    Error('Request to Business Central failed\ %1', GetLastErrorText());
            if not Response.IsSuccessStatusCode then
                Error('Request to Business Central failed\%1 %2', Response.HttpStatusCode, Response.ReasonPhrase);
            Response.Content.ReadAs(Result);
            JsonToken.ReadFrom(Result);
            JsonObject := JsonToken.AsObject();
            if JsonObject.Get('value', JsonToken) then
                JsonArray := JsonToken.AsArray();

            if CustomVendorTable.FindLast() then
                LineNo := CustomVendorTable."Line No."
            else
                LineNo := 0;

            foreach JsonToken in JsonArray do begin
                CustomVendorTable.Init();
                //CustomVendorTable."Line No." += LineNo;
                LineNo := LineNo + 1;
                CustomVendorTable."Line No." := LineNo;
                JsonObject := JsonToken.AsObject();
                if JsonObject.Get('number', JsonToken) then
                    CustomVendorTable."No." := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(CustomVendorTable."No."));
                if JsonObject.Get('displayName', JsonToken) then
                    CustomVendorTable.Name := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(CustomVendorTable.Name));
                if JsonObject.Get('lastModifiedDateTime', JsonToken) then
                    CustomVendorTable."Date/Time" := JsonToken.AsValue().AsDateTime();
                if JsonObject.Get('id', JsonToken) then
                    CustomVendorTable."Vendor SystemId" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(CustomVendorTable."Vendor SystemId"));
                if not CustomVendorTable.Insert() then
                    CustomVendorTable.Modify();
            end;
        end;
    end;

    local procedure GetAccessToken(/* TenantAadTeId: Text */)
    var
        OAuthSetup: Record "OAuth Setup";
        OAuth2: Codeunit OAuth2;
        Scopes: List of [Text];

    begin
        Scopes.Add('https://api.businesscentral.dynamics.com/.default');
        if OAuthSetup.Get() then begin
            if not OAuth2.AcquireTokenWithClientCredentials(OAuthSetup."Client ID", OAuthSetup."Client Secret", GetAuthorityUrl(OAuthSetup."Tenant ID"), '', Scopes, AccessToken) then
                Error('Failed to retrieve access token\ %1', GetLastErrorText());
            OAuthSetup.Token := CopyStr(AccessToken, 1, MaxStrLen(OAuthSetup.Token));
            AccesTokenExpires := CurrentDateTime + (3599 * 1000);
            OAuthSetup.Expiry := AccesTokenExpires;
            if not OAuthSetup.Insert() then
                OAuthSetup.Modify();
        end;
    end;

    local procedure GetAuthenticationHeaderValue(AccessToken: Text) Value: Text;
    begin
        Value := StrSubstNo('Bearer %1', AccessToken);
    end;

    local procedure GetAuthorityUrl(AadTenantId: Text) Url: Text
    var
    begin

        Url := AuthorityTxt;
        Url := Url.Replace('{AadTenantId}', AadTenantId);
    end;

    local procedure GetBCAPIUrl(BCEnvironmentName: Text; BCCOmpanyId: Text; Resource: Text) Url: Text;
    var
        OAuthSetup: Record "OAuth Setup";
    begin
        OAuthSetup.Get();
        Url := BCBaseUrlTxt;
        Url := Url.Replace('{BCEnvironmentName}', OAuthSetup."BC Environment Name")
                  .Replace('{BCCompanyId}', OAuthSetup."BC Company ID");
        Url := StrSubstNo('%1/%2', Url, Resource);
    end;

    local procedure CheckAccessToken()
    var
        OAuthSetup: Record "OAuth Setup";
    begin
        if OAuthSetup.Get() then
            if (OAuthSetup.Token = '') or (OAuthSetup.Expiry < CurrentDateTime) or (OAuthSetup.Expiry = 0DT) then
                GetAccessToken(/* OAuthSetup."Tenant ID" */);
    end;
}