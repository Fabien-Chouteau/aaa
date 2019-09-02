with Ada.Finalization;

generic
   type Held (<>) is private;
package AAA.Containers.Indefinite_Holders with Preelaborate is

   --  Simple holder to work around GNAT holders bug

   type Holder is tagged private;

   function To_Holder (Elem : Held) return Holder;

   function Is_Empty (This : Holder) return Boolean;

   function Is_Valid (This : Holder) return Boolean is (not This.Is_Empty);

   type Reference_Value (Element : access Held) is limited null record with
     Implicit_Dereference => Element;

   function Reference (This : in out Holder) return Reference_Value;

private

   type Held_Access is access all Held;

   type Holder is new Ada.Finalization.Controlled with record
      Item : Held_Access;
   end record;

   overriding
   procedure Adjust (This : in out Holder);

   overriding
   procedure Finalize (This : in out Holder);

end AAA.Containers.Indefinite_Holders;