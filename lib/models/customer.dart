class Customer
{
  final int customerID;
  final String customerName;
  final double customerTotalDues;
  final bool electronicMeterHasBeenRead;
  final DateTime ?customerMovementDate;

  Customer({required this.customerID, required this.customerName, required this.customerTotalDues, required this.electronicMeterHasBeenRead, required this.customerMovementDate});
   factory Customer.factory({required Map<String ,dynamic> jsonData})
{
  return Customer(customerID: jsonData['CustomerID']??0, customerName: jsonData['CustomerName']??'', customerTotalDues: double.parse(jsonData['CustomerTotalDues']),
   electronicMeterHasBeenRead:jsonData['ElectronicMeterHasBeenRead']==0?false:true , customerMovementDate:jsonData['CustomerMovementDate'] != null
        ? DateTime.parse(jsonData['CustomerMovementDate']['date'])
        :null);
}
}