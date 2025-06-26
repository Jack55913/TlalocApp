import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

class CommunityButton extends StatelessWidget {
  const CommunityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),

        // clipBehavior: Clip.antiAlias,
      ),
      child: Material(
        color: AppColors.blue1,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/community'),
          splashColor: Colors.white,
          highlightColor: Colors.white,
          child: Container(
            constraints: const BoxConstraints(minHeight: 200),
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Todos podemos PARTICIPAR',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: 'FredokaOne',
                          color: Colors.white,
                          height: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Descubre cómo preservar el Monte Tláloc y únete a nuestras acciones comunitarias',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Text(
                            'Más información',
                            style: Theme.of(
                              context,
                            ).textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/img-5.jpg',
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
