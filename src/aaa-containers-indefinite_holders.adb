with Ada.Unchecked_Deallocation;

package body AAA.Containers.Indefinite_Holders is

   ---------------
   -- To_Holder --
   ---------------

   function To_Holder (Elem : Held) return Holder is
     (Ada.Finalization.Controlled with
        Item => new Held'(Elem));

   --------------
   -- Is_Empty --
   --------------

   function Is_Empty (This : Holder) return Boolean is (This.Item = null);

   ---------------
   -- Reference --
   ---------------

   function Reference (This : in out Holder) return Reference_Value is
     (Element => This.Item);

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (This : in out Holder) is
   begin
      if This.Item /= null then
         This.Item := new Held'(This.Item.all);
      end if;
   end Adjust;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (This : in out Holder) is
      procedure Free is new Ada.Unchecked_Deallocation (Held, Held_Access);
   begin
      Free (This.Item);
   end Finalize;

end AAA.Containers.Indefinite_Holders;