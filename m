From: Stef Bon <stef@bononline.nl>
Subject: Re: sshfs and autofs
Date: Sun, 20 Dec 2009 16:54:47 +0100
Message-ID: <4B2E48C7.8010509@bononline.nl>
References: <1261107485-sup-320@nixos> <1261173402-sup-9510@nixos>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1261173402-sup-9510@nixos>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Marc Weber <marco-oweber@gmx.de>
Cc: autofs <autofs@linux.kernel.org>

Marc Weber wrote:
> The script I posted last let's still other users access your mounts
> which is bad.
> This script only queries the ssh-agents run by the uid specified in
> mount options (uid=..)
> It also uses sudo -u#uid to run ssfs causing a user mount.
> So other causes can still cause the mount. But they can't access the
> filesystem contents:
>
> # ls -l /auto/mlin;
> ls: cannot open directory /auto/mlin: Permission denied
>
> #  ls -l /auto
> ls: cannot access /auto/mlin: Permission denied
> total 0
> d????????? ? ? ? ?                ? mlin
>   
Well the question marks mean that glibc cannot figure out the 
permissions. This means probably
that the mount has not been succesfull.

> Whatever those question marks mean?
>
>
> Updated script
>
>     # setuid-wrappers for fusermount
>     export PATH=/var/setuid-wrappers:${pkgs.coreutils}/bin:${pkgs.sshfsFuse}/bin:${pkgs.openssh}/bin:${pkgs.procps}/bin:${pkgs.lsof}/bin:${pkgs.gnused}/bin/:${pkgs.sudo}/bin
>     pids=`pgrep ssh-agent`
>     # get uid=nr from arguments
>     uid=$(echo "$@"| sed -n 's@.*uid=\([0123456789]\+\).*@\1@p')
>     connect(){
>       sudo=$1; shift
>       $sudo sshfs -o ssh_command="ssh -o NumberOfPasswordPrompts=0" "$@" \
>        && exit 0 || true
>     }
>     # Change ownership of mountpoint. Ownership will be overridden when mount suceeds.
>     # Otherwise fusermount can't access it (?!)
>     chown $uid "$2"
>     chmod u+w "$2"
>     for p in $pids; do
>       res="$(lsof -p $p -a -U  -Fnu)"
>       user_id=$(echo "$res"| sed -n 's/^u//p')
>       if [ "$user_id" == "$uid" ]; then
>         export SSH_AUTH_SOCK=$(echo "$res"| sed -n 's/^n//p')
>         export SSH_AGENT_PID=$p
>         echo "trying to connect using ssh-agent $p $SSH_AUTH_SOCK" 1>&2
>         # by using sudo -u allow accessing mount by target user - Is there a better way to achieve this??
>         connect "sudo -E -u#$user_id" "$@"
>         echo -n " .. failed" 1>&2
>       fi
>     done
>     unset SSH_AGENT_PID; unset SSH_AUTH_SOCK
>
>     # no ssh-agent found or they all belong to different users..
>     # Try again. Maybe there is a key without password ?
>     # You should not be using this!
>     connect "" "$@"
>     exit 1
>
>   
Does this work. I do not know anything about ssh agents.

I n my construction I'm using the following command:

sshfs "$unc_address" "$mountpoint" -o allow_other -o 
PasswordAuthentication='no' -o IdentityFile="$homedir/.ssh/id_dsa" -o 
UserKnownHostsFile="$homedir/.ssh/known_hosts" -o Compression='yes'

where unc_address is of the form %USER%@192.168.0.1:

where user is like sbon (me) or root.
$homedir is the homedirectory of this user, and there has been a check 
the files like $homedir/.ssh/id_dsa are present.


This works. There is no construction to prevent other users to activate 
the mount.

I've created earlier a constrcution to mount ssh, and this was working 
with a mount.sshfs wrapper, which on his turn
called sshfs through above commands. This was working.

Now I'm working on a new construction which creates an seperate 
mountpoint for every user:

/mnt/mount.md5key/%USER%/mount

wher USER is again the user like sbon.

the directory /mnt/mount.md5key/%USER%
is owned by the user and has permissions 700, so no other user except 
root can access (and also activate) any mount.

Hope this helps.

Stef Bon



> Can I make automount create those key directories with user permissions
> as well so that other users can't even cause a mount?
>
> Is there a better way to restrict acess to a user only compared to using
> sudo?
>
> Marc Weber
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
>   
