page 50100 "OAuth Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "OAuth Setup";
    AdditionalSearchTerms = 'finance setup,general ledger setup,g/l setup';
    DeleteAllowed = false;
    InsertAllowed = true;
    layout
    {
        area(Content)
        {
            group("Azure APP Registration Credentials")
            {
                field("Client ID"; Rec."Client ID")
                {
                    ToolTip = 'Client ID';
                    ApplicationArea = All;
                }
                field("Tenant ID"; Rec."Tenant ID")
                {
                    ToolTip = 'Client Secret';
                    ApplicationArea = All;
                }
                field("Client Secret"; Rec."Client Secret")
                {
                    ToolTip = 'Client Secret';
                    ApplicationArea = All;
                }
                field("BC Company ID"; Rec."BC Company ID")
                {
                    ToolTip = 'BC Company ID';
                    ApplicationArea = All;

                }
                field("BC Environment Name"; Rec."BC Environment Name")
                {
                    ToolTip = 'BC Environment Name';
                    ApplicationArea = All;
                }
                field(Token; Rec.Token)
                {
                    ToolTip = 'Token';
                    ApplicationArea = All;
                }
                field(Expiry; Rec.Expiry)
                {
                    ToolTip = 'Token';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}