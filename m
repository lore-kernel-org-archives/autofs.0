From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Exporting UID to userspace?
Date: Sat, 5 Jun 2004 19:11:42 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200406051911.42780.robin.rosenberg.lists@dewire.com>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841A0@frodo.avalon.ru>
	<Pine.LNX.4.58.0406052343120.15861@donald.themaw.net>
	<Pine.LNX.4.58.0406052350020.15861@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406052350020.15861@donald.themaw.net>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org
Cc: raven@themaw.net

On Saturday 05 June 2004 17.52, raven@themaw.net wrote:
> > > The matter of this RFE is need to mount smbfs shares on behalf of
> > > requestng users, with their own passwords...
> > This has been raised before.
> > I'd like to do it but it isn't trivial so it's in the wait queue.
> > It's dificult because it requires that the packet which is used to
> > communicate with the daemon will need to be changed. This will break
> > backward compatibility with other versions.
..
> How will you provide a consistent Unix UID <-> Windows UID mapping?
> And on multiple machines for the same user, over OS re-install?
> Ian

Assuming that is a problemm... It's not for me. 

It's not an autofs problem. It's the user space problem to figure that. 
Winbind is one possibility, but other's are possible. In some settings u can
simply use the same name and assume the same name goes for windows. In other 
cases you can use a mapping table in the script that automount calls. Autofs
should just provide the local uid,gid from the calling process.

-- robin
