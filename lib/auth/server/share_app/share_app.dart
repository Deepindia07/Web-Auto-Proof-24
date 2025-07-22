part of "share_route_imple.dart";

class ShareAppButton extends StatelessWidget {
  final String? customMessage;
  final String? subject;
  final IconData? icon;
  final String? buttonText;
  final Color? color;

  const ShareAppButton({
    Key? key,
    this.customMessage,
    this.subject,
    this.icon,
    this.buttonText,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShareBloc, ShareState>(
      listener: (context, state) {
        if (state is ShareSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is ShareError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: state is ShareLoading
              ? null
              : () {
            context.read<ShareBloc>().add(
              ShareAppEvent(
                subject: subject,
                customMessage: customMessage,
              ),
            );
          },
          icon: state is ShareLoading
              ? const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
              : Icon(icon ?? Icons.share),
          label: Text(buttonText ?? 'Share App'),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
        );
      },
    );
  }
}

// Alternative: Share ListTile for menus/drawers
class ShareAppListTile extends StatelessWidget {
  final String? customMessage;
  final String? subject;

  const ShareAppListTile({
    Key? key,
    this.customMessage,
    this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShareBloc, ShareState>(
      listener: (context, state) {
        if (state is ShareSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is ShareError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: ListTile(
        leading: const Icon(Icons.share),
        title: const Text('Share This App'),
        subtitle: const Text('Recommend to friends'),
        onTap: () {
          context.read<ShareBloc>().add(
            ShareAppEvent(
              subject: subject,
              customMessage: customMessage,
            ),
          );
        },
      ),
    );
  }
}
