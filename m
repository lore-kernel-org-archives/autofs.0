From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS4
Date: Wed, 17 Dec 2003 09:48:02 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0312170945330.27456-100000@wombat.indigo.net.au>
References: <3FC3FB65000A73F7@mssazhb-int.msg.bluewin.ch>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FC3FB65000A73F7@mssazhb-int.msg.bluewin.ch>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Eric Cuendet <jean-eric.cuendet@bluewin.ch>
Cc: autofs@linux.kernel.org

On Mon, 15 Dec 2003, Jean-Eric Cuendet wrote:

> Hi,
> I read that autofs4 can mount an entire NFS tree on /net like on solaris.
>
> I wonder if it is also possible to mount a complete tree of Windows servers
> (Samba) on /smb for example?

This is done using a socalled program map. It is up to the administrator
to write the program map script to return required map entries. This could
be smb mounts if you want.
