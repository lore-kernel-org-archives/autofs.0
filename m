From: Ian Kent <raven@themaw.net>
Subject: Re: some questions about the configuration
Date: Tue, 24 Jan 2006 21:11:37 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0601242036050.3037@eagle.themaw.net>
References: <43D4F1E0.2060201@inria.fr>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43D4F1E0.2060201@inria.fr>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Mon, 23 Jan 2006, Guillaume Rousse wrote:

> I recently started to clean-up the mandriva autofs package a bit, and I
> have some questions about the default configuration handling.
> 
> First, it seems autofs-ldap-auto-master, which is installed in
> /usr/lib/autofs, and auto.{net,smb}, which are installed in /etc, have
> exactly the same purpose: to automatically produce a list of available
> mount points from a remote host. If I am right, why are them installed
> and named differently ? Apart the fact that the first one is native
> code, whereas the others are shell scripts, they could as well get
> installed as /usr/lib/autofs/auto.{ldap,smb,net}

the autofs-ldap-auto-master reads the master map from an ldap server. Only 
the master map.

All the things in /usr/lib/autofs are system things, internal, whereas 
things in the map directory, often /etc are the user maps. The example 
program maps auto.smb and auto.net are, well, examples. Given a key they 
return the entry for it. Neither returns master map entries.

The master map and the maps that are contained in the master map have a 
different syntax.

> 
> Second, it's not clear why ldap and nis use are triggered from the
> content of /etc/nsswitch.conf, while smb and net (simple rpcinfo
> listing) use are triggered from content of /etc/auto.master. Shouldn't
> all those syntax be available from both locations?

Master vs client maps again.

Ian
