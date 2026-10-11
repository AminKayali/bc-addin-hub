namespace BCAddinHub.MyAddIn;

page 50000 "MyAddIn Demo"
{
    PageType = Card;
    Caption = 'MyAddIn Demo';
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            usercontrol(MyAddIn; MyAddIn)
            {
                ApplicationArea = All;

                trigger ControlReady()
                begin
                    CurrPage.MyAddIn.DoSomething('Hello from AL');
                end;

                trigger SomethingHappened(Value: Text)
                begin
                    Message('JavaScript says: %1', Value);
                end;
            }
        }
    }
}
