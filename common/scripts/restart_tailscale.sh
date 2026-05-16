#!/run/current-system/sw/bin/bash

echo "Deactivate tailscale"
/run/current-system/sw/bin/tailscale down
echo "Wait for 10 seconds..."
sleep 10
echo "Reactivate tailscale"
/run/current-system/sw/bin/tailscale up
