From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: sshfs and autofs
Date: Tue, 22 Dec 2009 22:45:51 +0100
Message-ID: <1261518309-sup-4721@nixos>
References: <1261107485-sup-320@nixos> <1261173402-sup-9510@nixos>
	<4B2E48C7.8010509@bononline.nl> <1261391275-sup-7258@nixos>
	<4B311928.9070503@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <4B311928.9070503@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs <autofs@linux.kernel.org>

Excerpts from Stef Bon's message of Tue Dec 22 20:08:24 +0100 2009:
> Marc Weber wrote:
> >>> #  ls -l /auto
> >>> ls: cannot access /auto/mlin: Permission denied
> >>> total 0
> >>> d????????? ? ? ? ?                ? mlin
> >>>   
> >>>       
> >> Well the question marks mean that glibc cannot figure out the 
> >> permissions. This means probably
> >> that the mount has not been succesfull.
> >>     
> > It was. The user can access it. But root can't.
> >
> >   
> >> Does this work. I do not know anything about ssh agents.
> >>     
> > Than you should start to learn at least some basics.
Sorry. I should have been more specific.
I tried saying: If you have to login to multiple locations very often
you should learn about ssh-agents because you'll benefit doing so.

That's one point. The second point is if you still don't know about them
and you're not going to read up what they are and why they are exist
there is indeed no point you helping me because the reason I wrote that
script was using ssh-agents.

Anyway I think we can meet. You didn't reply to my question whether
you're using empty passwords. So it looks to me that you're not aware
about what I'm talking when saying "empty password". This looks strange
to me because using automount directories per users seems to be
advanced to me.

Let me show you a complete example how to generate a key and use an
ssh-agent:

  # important: enter a passphrase

  ssh-keygen -t rsa -f $HOME/id_rsa_tmp
  Enter passphrase (empty for no passphrase): PASSWORD
  Your identification has been saved in $HOME/id_rsa_tmp.
  Your public key has been saved in $HOME/id_rsa_tmp.pub.
    
  # now you can copy your key to remote machine, you have to enter your
  # remote password once:
  ssh-copy-id -i $HOME/id_rsa_tmp.pub user@remote

  Now you can login using
  ssh -i $HOME/id_rsa_tmp user@remote

  If you didn't use an empty password ssh will ask you for the id_rsa_tmp
  password each time uses the key.
  If you login and out frequently this is tedious. That's why you can do

  tmp=$(ssh-agent)
  echo "$tmp"
  eval "$tmp"
  ssh-add $HOME/id_rsa_tmp # thell the agent enter passphrase
  # no more passwords required:
  ssh user@remote 'echo done'
  ssh user@remote 'echo done'
  # kill agent so that when you leave the pc nobody
  # else can use your key. You can also specify timeouts and such.
  # (-> man ssh-agent)
  pkill -9 ssh-agent 

Of course if you're using an empty passphrase you don't need the
ssh-agent at all.
However if someone get's access to your private key he can login.
If you use a passphrase he can't because he still has to know your
passphrase.

Now you've been using this line without ssh-agent:
> >> PasswordAuthentication='no' -o IdentityFile="$homedir/.ssh/id_dsa" -o 

What would happen if you replaced .ssh/id_dsa with $HOME/id_rsa_tmp
assuming you entered a passphrase?
automount is running mount running sshfs running ssh
which will find your password protected key. It doesn't know about any
agents so it will try to ask you for the password by printing a
"password:" prompt. But automount has no shell thus no prompt thus the
mount will fail.

For this reason you find many howtos when googling telling you how to
setup keys with empty passwords because this just works.

I have two goals:
a) figuring out whether there are even nicer solutions
b) telling people that they can use password protected private keys and
automount using my script.

> Here again I'm trying to help here.
Thanks for doing so.

I hope that this mail showing you how to use ssh-agents does help you a
little bit understanding my configuration.

Marc Weber
