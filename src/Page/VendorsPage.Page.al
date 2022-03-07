page 50105 "Vendors OAuth"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Vendor Table";
    Caption = 'Vendors OAuth';
    Editable = false;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Name';
                    ApplicationArea = All;
                }
                field("Date/Time"; Rec."Date/Time")
                {
                    ToolTip = 'Last modified Date/Time vendor from vendors table';
                    ApplicationArea = All;
                }
                // field(SystemId; Rec.SystemId)
                // {
                //     ToolTip = 'No.';
                //     ApplicationArea = All;
                // }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'SystemCreatedAt';
                    ApplicationArea = All;
                }
                // field(SystemModifiedAt; Rec.SystemModifiedAt)
                // {
                //     ToolTip = 'Modified At';
                //     ApplicationArea = All;
                // }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Line No.';
                    ApplicationArea = All;
                }
                field("Vendor SystemId"; Rec."Vendor SystemId")
                {
                    ToolTip = 'Vendors SystemId from vendors table';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Vendors)
            {
                ApplicationArea = all;
                Image = Vendor;
                Caption = 'Vendors';
                ToolTip = ' ';
                trigger OnAction()
                var
                    VendorMgt: Codeunit "Vendor Mgt";
                begin
                    VendorMgt.Run()
                end;
            }
        }
    }
}