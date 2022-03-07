page 50104 CustomVendorAPI
{
    PageType = API;
    Caption = 'API';
    APIPublisher = 'dynamics';
    APIGroup = 'demo';
    APIVersion = 'v2.0';
    EntityName = 'test';
    EntitySetName = 'tests';
    SourceTable = "Vendor Table";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    Editable = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(number; Rec."No.")
                {
                    ToolTip = 'No.';
                    ApplicationArea = All;
                }
                field(displayName; Rec.Name)
                {
                    ToolTip = 'Name';
                    ApplicationArea = All;
                }
                field(lastModifiedDateTime; Rec."Date/Time")
                {
                    ToolTip = 'Last modified Date/Time vendor from vendors table';
                    ApplicationArea = All;
                }
                // field(SystemId; Rec.SystemId)
                // {
                //     ToolTip = 'No.';
                //     ApplicationArea = All;
                // }
                // field(systemCreatedAt; Rec.SystemCreatedAt)
                // {
                //     ToolTip = 'SystemCreatedAt';
                //     ApplicationArea = All;
                // }
                // field(systemModifiedAt; Rec.SystemModifiedAt)
                // {
                //     ToolTip = 'Modified At';
                //     ApplicationArea = All;
                // }
                // field("Line No."; Rec."Line No.")
                // {
                //     ToolTip = 'Line No.';
                //     ApplicationArea = All;
                // }
                field(id; Rec."Vendor SystemId")
                {
                    ToolTip = 'Vendors SystemId from vendors table';
                    ApplicationArea = All;
                }
            }
        }
    }
}