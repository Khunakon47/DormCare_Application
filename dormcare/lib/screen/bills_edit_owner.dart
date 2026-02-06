import 'package:dormcare/model/tenant_model.dart';
import 'package:flutter/material.dart';

class BillsEditOwner extends StatelessWidget {
  final TenantModel tenant;

  const BillsEditOwner({
    super.key,
    required this.tenant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Edit", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
                Text(
                  "Room ${tenant.roomNumber} - ${tenant.username}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          bottom: 36,
          top: 12,
          left: 16,
          right: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    splashFactory: InkRipple.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: SizedBox(
                height: 48,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    splashFactory: InkRipple.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 24,
          top: 16, left: 16, right: 16,
        ),
        child: Column(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rent Fee", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none, 
                            hintText: "Search by room...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text("THB", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),),
                    ],
                  ),
                )
              ],
            ),

            SizedBox(height: 15,),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withValues(alpha: 0.25),
                border: Border.all(width: 1, color: Colors.blueAccent, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(children: [
                    Icon(Icons.water_drop_outlined, color: Colors.blueAccent, size: 24,),
                    Text("Water Bill", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueAccent),),
                  ],),

                  SizedBox(height: 10,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Units used",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 35, // give fixed height
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter units",
                            contentPadding: EdgeInsets.only(
                              left: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price per Units (THB)",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10,),

                      SizedBox(
                        height: 35, // give fixed height
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                              left: 12,
                            ),
                            hintText: "Enter units",
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withValues(alpha: 0.25),
                      border: Border.all(width: 1, color: Colors.blueAccent, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("Total:", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold,),),
                      Text("2032 THB", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold,),),
                    ],),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15,),
            
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amberAccent.withValues(alpha: 0.25),
                border: Border.all(width: 1, color: Colors.amber, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(children: [
                    Icon(Icons.water_drop_outlined, color: Colors.amber, size: 24,),
                    Text("Electric Bill", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.amber),),
                  ],),

                  SizedBox(height: 10,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Units used",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 35, // give fixed height
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter units",
                            contentPadding: EdgeInsets.only(
                              left: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price per Units (THB)",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10,),

                      SizedBox(
                        height: 35, // give fixed height
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                              left: 12,
                            ),
                            hintText: "Enter units",
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amberAccent.withValues(alpha: 0.25),
                      border: Border.all(width: 1, color: Colors.amberAccent, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("Total:", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold,),),
                      Text("2032 THB", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold,),),
                    ],),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15,),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Other Changes", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20,),),
                    TextButton(onPressed: ()=>{}, child: Row(children: [
                      Icon(Icons.add, color: Colors.blue, size: 28,),
                      Text("Add Item", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),),
                    ],)),
                ],),

                SizedBox(height: 5,),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text("No Additional Changes", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 16),),
                )
              ],
            ),

            SizedBox(height: 15,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Payment Status", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20,),),

                SizedBox(height: 5,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: const WidgetStatePropertyAll(Colors.red),
                      ),
                      child: const Text(
                        "Unpaid",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ),),

                    const SizedBox(width: 10),

                    Expanded(child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.black.withValues(alpha: 0.25)),
                      ),
                      child: const Text(
                        "Paid",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ),),
                  ],
                )
              ],
            ),

            SizedBox(height: 15,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Note",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const TextField(
                    maxLines: null,          // allows multiple lines
                    expands: true,           // fills container height
                    textAlignVertical: TextAlignVertical.top,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Eg. Late payment...",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15,),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Grand Total:", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),),
                  Text("3020 THB", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}