From: raven@themaw.net
Subject: Re: samba stop and autofs stop
Date: Sat, 30 Apr 2005 00:08:04 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504300006220.4049@donald.themaw.net>
References: <215ff441050429074949954080@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <215ff441050429074949954080@mail.gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Chris Fanning <christopher.fanning@gmail.com>
Cc: autofs@linux.kernel.org

On Fri, 29 Apr 2005, Chris Fanning wrote:

> Hello all,
>
> I have a server running samba for some windows clients.
> Now, one the same client network, I am setting up some thin clients
> that open their desktop session, in this case, the same server that's
> running samba.
>
> Because I've got some windows and some thin clients running kde, samba
> is still necesary.
>
> Some of the samba shares are common to all users so I'm trying to use
> autofs to mount them.
>
> It works but.
> When I shutdown the server it freezes. It seems to be because the
> samba server is shutdown before automount. Does that sound right?

Yes. There are often problems with umounting taking a long time for 
servers that have gone away. The NFS side of things has improved in this 
respect quite a bit. I don't know for sure about smbfs though.

Ian
