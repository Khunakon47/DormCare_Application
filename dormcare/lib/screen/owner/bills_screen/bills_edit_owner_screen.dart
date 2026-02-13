import 'package:dormcare/component/owner/custom_textbutton.dart';
import 'package:dormcare/model/owner/monthly_billing_model.dart';
import 'package:flutter/material.dart';

class BillsEditOwner extends StatelessWidget {
  final MonthlyBillingModel bill;

  const BillsEditOwner({
    super.key,
    required this.bill,
  });

  


  @override
  Widget build(BuildContext context) {

    final totalWater = bill.water * bill.waterUnit;
    final totalElectric = bill.electric * bill.electricUnit;
    final totalGrand = bill.rent + totalWater + totalElectric;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Edit", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
                Text(
                  "Room ${bill.roomNumber}",
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
            Expanded(child: CustomTextbutton(
              textOnBtn: "Cancel",
              outLined: true,
              fgColor: Colors.black,
              fontSize: 16,
              onPressed: () {
                Navigator.pop(context);
              },
            )),

            const SizedBox(width: 12),

            Expanded(child: CustomTextbutton(
              textOnBtn: "Save Changes",
              fgColor: Colors.white,
              bgColor: [Colors.purple],
              fontSize: 16,
              onPressed: () {
                Navigator.pop(context);
              },
            )),
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
                            hintText: bill.rent.toString(),
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
                            hintText: bill.water.toString(),
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
                            hintText: bill.waterUnit.toString(),
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
                      Text("${bill.water * bill.waterUnit} THB", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold,),),
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
                            hintText: bill.electric.toString(),
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
                            hintText: bill.electricUnit.toString(),
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
                      Text("${bill.electric * bill.electricUnit} THB", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold,),),
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
                    CustomTextbutton(
                      textOnBtn: "Add Item",
                      textBtnOnly: true,
                      fgColor: Colors.blue,
                      fontSize: 14,
                      icon: Icon(Icons.add),
                      iconColor: Colors.blue,
                      iconSize: 28,
                    ),
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
                    Expanded(child: CustomTextbutton(
                      textOnBtn: "Unpaid",
                      bgColor: [Colors.purple],
                      fgColor: Colors.white,
                    )),

                    const SizedBox(width: 10),

                    Expanded(child: CustomTextbutton(
                      textOnBtn: "Paid",
                      bgColor: [Colors.black.withValues(alpha: 0.25)],
                    )),
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
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Grand Total:", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),),
                  Text("$totalGrand THB", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}