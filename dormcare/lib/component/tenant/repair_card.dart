import 'package:flutter/material.dart';
import '../../model/tenant/repair_model.dart';

class RepairCard extends StatelessWidget {
  final RepairModel data;
  final VoidCallback onTap;

  const RepairCard({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: data.imageUrl.isNotEmpty
                  ? Image.network(
                      data.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        );
                      },
                    )
                  : const Center(
                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        data.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: data.statusBgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        data.statusText,
                        style: TextStyle(
                          color: data.statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                Text(
                  data.date,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),

                const SizedBox(height: 8),

                Text(
                  data.description,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onTap,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFF2962FF),
                      ), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        color: Color(0xFF2962FF),
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
