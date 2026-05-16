#!/run/current-system/sw/bin/bash

echo "Deactivate tailscale"
/run/current-system/sw/bin/tailscale down
echo "Wait for 5 seconds..."
sleep 5
echo "Reactivate tailscale"
/run/current-system/sw/bin/tailscale up
