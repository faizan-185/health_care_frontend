class MedicineOrder{
  int muId;
  int quantity;
  MedicineOrder({required this.muId, required this.quantity});
  Map<String, int> toJson() => {
    'muId': muId,
    'quantity': quantity,
  };
}