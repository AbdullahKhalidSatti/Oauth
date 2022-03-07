table 50105 "Vendor Table"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(4; "Date/Time"; DateTime)
        {
            Caption = 'Last modified Date/Time from vendors table';
        }
        field(5; "Vendor SystemId"; Text[50])
        {
            Caption = 'Vendor SystemId from Vendors Table';
        }
    }

    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }

}