table 50100 "OAuth Setup"
{
    Caption = 'OAuth 2.0 Setup';
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Client ID"; Text[50])
        {
            Caption = 'Client ID';
            InitValue = '3be17dad-f580-4a4b-a2e1-24521c099410';
        }
        field(3; "Tenant ID"; Text[50])
        {
            Caption = 'Tenant ID';
            InitValue = '3970bc17-9986-41cd-93ae-7b1a1b05c712';
        }
        field(4; "Client Secret"; Text[50])
        {
            Caption = 'Client Secret';
            InitValue = 'cki7Q~m35lHQB8dYnbyqfSvUh6rLgNLoer1F2';
        }
        field(5; "BC Environment Name"; Text[20])
        {
            Caption = 'BC Environment Name';
            InitValue = 'Sandbox';
        }
        field(6; "BC Company ID"; Text[50])
        {
            Caption = 'BC Company ID';
            InitValue = '9e4c94af-c141-ec11-bb7b-000d3a256200';
        }
        field(7; "Token"; Text[2048])
        {
            Caption = 'Access Token';
        }
        field(8; Expiry; DateTime)
        {
            Caption = 'Token Expiry Time';
        }

    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}