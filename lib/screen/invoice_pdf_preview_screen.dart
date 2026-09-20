import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePdfHelper {
  static Future<Uint8List> generateInvoicePdf({
    String invoiceId = 'INV-2024-082',
    String clientName = 'Vanguard Properties',
    String totalAmount = '18,450.00',
    String issueDate = 'AUG 14, 2024',
    String dueDate = 'Sept 12, 2026',
    String status = 'PENDING',
    List<Map<String, String>> items = const [
      {
        'title': 'Structural Planning',
        'subtext': 'Comprehensive load-bearing analysis and CAD drafting for Phase 2 expansion.',
        'amount': '8,200.00',
      },
      {
        'title': 'Material Procurement',
        'subtext': 'Sourcing of reclaimed Italian travertine and custom oak millwork.',
        'amount': '6,750.00',
      },
      {
        'title': 'Site Consultation',
        'subtext': '4x On-site inspections and coordination with structural engineers.',
        'amount': '3,500.00',
      },
    ],
  }) async {
    final pdf = pw.Document();

    final darkRed = PdfColor.fromHex('#580B02');
    final cardPink = PdfColor.fromHex('#FCEFEA');
    final titleDark = PdfColor.fromHex('#2A0501');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'RIPAL DESIGN',
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                            color: darkRed,
                          ),
                        ),
                        pw.Text(
                          'Architectural & Interior Design Studio',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                        pw.Text(
                          'Rajkot & Khambhalia, Gujarat',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                      ],
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: pw.BoxDecoration(
                        color: darkRed,
                        borderRadius: pw.BorderRadius.circular(6),
                      ),
                      child: pw.Text(
                        'TAX INVOICE',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Divider(color: PdfColors.grey300, thickness: 1),
                pw.SizedBox(height: 16),

                // Invoice & Client Info
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'BILL TO:',
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          clientName,
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: titleDark,
                          ),
                        ),
                        pw.Text(
                          'Attn: Sarah J. - Phase 2 Expansion',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'INVOICE NO: $invoiceId',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                            color: titleDark,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Issue Date: $issueDate',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                        pw.Text(
                          'Due Date: $dueDate',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                        pw.Text(
                          'Status: $status',
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: darkRed,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 24),

                // Table
                pw.Table(
                  border: pw.TableBorder.all(
                      color: PdfColors.grey300, width: 0.5),
                  children: [
                    // Table Header
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('#',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 10)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('Service Description',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 10)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('Amount (INR)',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 10),
                              textAlign: pw.TextAlign.right),
                        ),
                      ],
                    ),

                    // Table Items
                    ...items.asMap().entries.map((entry) {
                      final idx = entry.key + 1;
                      final item = entry.value;
                      return pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text('$idx',
                                style: const pw.TextStyle(fontSize: 10)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(item['title'] ?? '',
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 10)),
                                pw.SizedBox(height: 2),
                                pw.Text(item['subtext'] ?? '',
                                    style: const pw.TextStyle(
                                        fontSize: 9, color: PdfColors.grey700)),
                              ],
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text('INR ${item['amount'] ?? ''}',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10),
                                textAlign: pw.TextAlign.right),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
                pw.SizedBox(height: 20),

                // Total Summary
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Container(
                      width: 220,
                      padding: const pw.EdgeInsets.all(12),
                      decoration: pw.BoxDecoration(
                        color: cardPink,
                        borderRadius: pw.BorderRadius.circular(8),
                      ),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'TOTAL DUE:',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: titleDark,
                            ),
                          ),
                          pw.Text(
                            'INR $totalAmount',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: darkRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 40),

                // Footer & Terms
                pw.Divider(color: PdfColors.grey300, thickness: 1),
                pw.SizedBox(height: 12),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'TERMS & CONDITIONS:',
                          style: pw.TextStyle(
                            fontSize: 9,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey700,
                          ),
                        ),
                        pw.Text(
                          '1. Payment due within 30 days of invoice date.',
                          style: const pw.TextStyle(
                              fontSize: 8, color: PdfColors.grey600),
                        ),
                        pw.Text(
                          '2. Payable to Ripal Design Studio via Bank Transfer/UPI.',
                          style: const pw.TextStyle(
                              fontSize: 8, color: PdfColors.grey600),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'Ar. Ripal Patel',
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                            color: darkRed,
                          ),
                        ),
                        pw.Text(
                          'Authorized Signature',
                          style: const pw.TextStyle(
                              fontSize: 8, color: PdfColors.grey600),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}

class InvoicePdfPreviewScreen extends StatelessWidget {
  final String invoiceId;
  final String clientName;
  final String totalAmount;
  final String issueDate;
  final String dueDate;
  final String status;
  final List<Map<String, String>> items;

  const InvoicePdfPreviewScreen({
    super.key,
    this.invoiceId = 'INV-2024-082',
    this.clientName = 'Vanguard Properties',
    this.totalAmount = '18,450.00',
    this.issueDate = 'AUG 14, 2024',
    this.dueDate = 'Sept 12, 2026',
    this.status = 'PENDING',
    this.items = const [
      {
        'title': 'Structural Planning',
        'subtext': 'Comprehensive load-bearing analysis and CAD drafting for Phase 2 expansion.',
        'amount': '8,200.00',
      },
      {
        'title': 'Material Procurement',
        'subtext': 'Sourcing of reclaimed Italian travertine and custom oak millwork.',
        'amount': '6,750.00',
      },
      {
        'title': 'Site Consultation',
        'subtext': '4x On-site inspections and coordination with structural engineers.',
        'amount': '3,500.00',
      },
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF580B02)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '$invoiceId PDF Preview',
          style: const TextStyle(
            color: Color(0xFF580B02),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: PdfPreview(
        build: (format) => InvoicePdfHelper.generateInvoicePdf(
          invoiceId: invoiceId,
          clientName: clientName,
          totalAmount: totalAmount,
          issueDate: issueDate,
          dueDate: dueDate,
          status: status,
          items: items,
        ),
        allowPrinting: true,
        allowSharing: true,
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        pdfFileName: '$invoiceId.pdf',
        previewPageMargin: const EdgeInsets.all(16),
      ),
    );
  }
}
