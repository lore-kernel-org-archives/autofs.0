From: Marc Weber <marco-oweber@gmx.de>
Subject: sshfs and autofs
Date: Fri, 18 Dec 2009 05:08:29 +0100
Message-ID: <1261107485-sup-320@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs <autofs@linux.kernel.org>

If you google for sshfs and autofs you'll find many howtos telling you
to create a private key without passwords because this works.
Most of of those Howtos tell you as well that you should not be doing
this for security reasons..

I've found another solution:
It tries connecting to each running ssh-agent. The first being able to
connect to the ssh location will be used. This way you can keep using
passwords and still use autofs.

  #!/bin/sh -e
  # PATH must contains openssh, sed, sshfs lsof and pgrep
  pids=`pgrep ssh-agent`
  if [ -z "$pids" ]; then
    # no ssh-agent found. Maybe there is a key without password ? You should not be using this!
    sshfs -o ssh_command="ssh -o NumberOfPasswordPrompts=0" "$@"
  else
  for p in $pids; do
    export SSH_AGENT_PID=$p
    export SSH_AUTH_SOCK=$(lsof -p $p -a -U  -Fn | sed -n 's/^n//p')
    echo "trying to connect using ssh-agent $p $SSH_AUTH_SOCK" 1>&2
      sshfs -o ssh_command="ssh -o NumberOfPasswordPrompts=0" "$@" && exit 0 || true
  done
  exit 1
  fi

Of course it is just a dirty script. However it does a much better job
than using no password.

Do you host such examples somewhere as well?

Marc Weber
