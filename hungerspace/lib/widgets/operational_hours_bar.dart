// lib/widgets/operational_hours_bar.dart - MOBILE OPTIMIZED WITH HIGHLIGHTING
import 'package:flutter/material.dart';
import '../models/operational_hours.dart';

class OperationalHoursBar extends StatelessWidget {
  final OperationalHours? operationalHours;

  const OperationalHoursBar({super.key, required this.operationalHours});

  @override
  Widget build(BuildContext context) {
    if (operationalHours == null) {
      return const SizedBox.shrink();
    }

    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Header with Room Number
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.orange, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Operational Hours',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            _buildStatusBadge(),
          ],
        ),

        const SizedBox(height: 12),

        // Room Number - Prominently Highlighted
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: Colors.orange, size: 16),
              const SizedBox(width: 6),
              Text(
                'Room: 4E-129/132',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Time Slots - Enhanced
        Column(
          children: [
            _buildHighlightedTimeSlot(
              'Till 12pm',
              operationalHours!.till12pm,
              Colors.blue,
            ),
            const SizedBox(height: 8),
            _buildHighlightedTimeSlot(
              '12pm - 2am',
              operationalHours!.from12pmTo2am,
              Colors.purple,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.access_time, color: Colors.orange, size: 20),

        const SizedBox(width: 16),
        _buildHighlightedTimeSlot(
          'Till 12pm',
          operationalHours!.till12pm,
          Colors.blue,
        ),
        const SizedBox(width: 16),
        Container(width: 1, height: 20, color: Colors.grey[600]),
        const SizedBox(width: 16),
        _buildHighlightedTimeSlot(
          'After 12pm',
          operationalHours!.from12pmTo2am,
          Colors.purple,
        ),
        const SizedBox(width: 16),
        _buildStatusBadge(),
      ],
    );
  }

  Widget _buildHighlightedTimeSlot(
    String period,
    String hours,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: accentColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                period,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                hours,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    final isOpen = _isCurrentlyOpen();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isOpen ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: (isOpen ? Colors.green : Colors.red).withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            isOpen ? 'OPEN' : 'CLOSED',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  bool _isCurrentlyOpen() {
    final now = DateTime.now();
    final hour = now.hour;
    return hour >= 18 || hour <= 2;
  }
}
