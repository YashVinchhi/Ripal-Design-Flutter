import 'package:flutter/material.dart';

class AdminCreateInvoiceScreen extends StatefulWidget {
  const AdminCreateInvoiceScreen({super.key});

  @override
  State<AdminCreateInvoiceScreen> createState() => _AdminCreateInvoiceScreenState();
}

class _AdminCreateInvoiceScreenState extends State<AdminCreateInvoiceScreen> {
  static const Color _bgWarm = Color(0xFFFFF7F2);
  static const Color _cardPink = Color(0xFFFCEFEA);
  static const Color _cardItemBg = Color(0xFFFDF8F5);
  static const Color _darkRed = Color(0xFF580B02);
  static const Color _brownBtn = Color(0xFF8B3A1C);
  static const Color _titleDark = Color(0xFF2A0501);
  static const Color _labelBrown = Color(0xFF7C5D53);
  static const Color _draftText = Color(0xFFA35D43);
  static const Color _draftBg = Color(0xFFFCECE4);

  String selectedClient = 'Rachit Dudhaiya';
  final TextEditingController _invoiceNumController = TextEditingController(text: 'INV-2024-089');
  final TextEditingController _issueDateController = TextEditingController(text: '10/04/2026');
  final TextEditingController _dueDateController = TextEditingController(text: '11/09/2026');
  final TextEditingController _taxController = TextEditingController(text: '10');
  final TextEditingController _discountController = TextEditingController(text: '0.00');

  final List<Map<String, String>> _lineItems = [
    {
      'title': 'Structural Planning',
      'desc': 'Phase 1 structural analysis and schematic drafting.',
      'amount': '12500.00',
    },
    {
      'title': 'Site Consultation',
      'desc': 'Description (Optional)',
      'amount': '1500.00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgWarm,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: _titleDark, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create Invoice',
          style: TextStyle(
            color: _titleDark,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _draftBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'DRAFTS',
                  style: TextStyle(
                    color: _draftText,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Client Selector
              const Text(
                'CLIENT',
                style: TextStyle(
                  color: _labelBrown,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: _cardPink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedClient,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: _titleDark),
                    items: ['Rachit Dudhaiya', 'Vanguard Properties', 'Rajibul Islam']
                        .map((c) => DropdownMenuItem(
                              value: c,
                              child: Text(
                                c,
                                style: const TextStyle(
                                  color: _titleDark,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => selectedClient = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Invoice Number
              const Text(
                'INVOICE NUMBER',
                style: TextStyle(
                  color: _labelBrown,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _invoiceNumController.text,
                style: const TextStyle(
                  color: _titleDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),

              // Issue Date
              const Text(
                'ISSUE DATE',
                style: TextStyle(
                  color: _labelBrown,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _issueDateController.text,
                style: const TextStyle(
                  color: _titleDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),

              // Due Date
              const Text(
                'DUE DATE',
                style: TextStyle(
                  color: _labelBrown,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _dueDateController.text,
                style: const TextStyle(
                  color: _titleDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),

              // Service Breakdown Header
              const Text(
                'SERVICE BREAKDOWN',
                style: TextStyle(
                  color: _labelBrown,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              const Divider(color: Color(0xFFE8D5CE), height: 1),
              const SizedBox(height: 16),

              // Line Items
              ..._lineItems.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _cardItemBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _titleDark,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['desc']!,
                            style: TextStyle(
                              fontSize: 13,
                              color: item['desc']!.contains('Optional')
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                '₹',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: _darkRed,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                item['amount']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: _titleDark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),

              // Add Line Item Button
              GestureDetector(
                onTap: () {
                  setState(() {
                    _lineItems.add({
                      'title': 'New Line Item',
                      'desc': 'Description',
                      'amount': '1000.00',
                    });
                  });
                },
                child: Row(
                  children: const [
                    Icon(Icons.add, color: _darkRed, size: 18),
                    SizedBox(width: 4),
                    Text(
                      'Add Line Item',
                      style: TextStyle(
                        color: _darkRed,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Tax & Discount Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TAX (VAT/GST) %',
                          style: TextStyle(
                            color: _labelBrown,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _taxController.text,
                          style: const TextStyle(
                            color: _titleDark,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DISCOUNT ₹',
                          style: TextStyle(
                            color: _labelBrown,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _discountController.text,
                          style: const TextStyle(
                            color: _titleDark,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Totals Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _cardPink,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Subtotal', style: TextStyle(fontSize: 14, color: _titleDark)),
                        Text('₹14,000.00', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleDark)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Tax (10%)', style: TextStyle(fontSize: 14, color: _titleDark)),
                        Text('₹1,400.00', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleDark)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Discount', style: TextStyle(fontSize: 14, color: _titleDark)),
                        Text('-₹0.00', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleDark)),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(color: Color(0xFFE8D5CE), height: 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: _titleDark,
                          ),
                        ),
                        Text(
                          '₹15,400.00',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: _titleDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Action Buttons
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invoice Generated Successfully')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _brownBtn,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Generate Invoice',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Draft Saved Successfully')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _cardPink,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Draft',
                    style: TextStyle(
                      color: _brownBtn,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _invoiceNumController.dispose();
    _issueDateController.dispose();
    _dueDateController.dispose();
    _taxController.dispose();
    _discountController.dispose();
    super.dispose();
  }
}
