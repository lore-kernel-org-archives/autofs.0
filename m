From: Ryan Go <ryan@rentec.com>
Subject: Re: making the mountpoints visible all the time
Date: Fri, 14 Nov 2003 10:09:04 -0500 (EST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0311141006580.26051@vulture.rentec.com>
References: <Pine.LNX.4.33.0311141100050.30495-100000@wombat.indigo.net.au>
 <3FB4C6CF.7030100@yahoo.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FB4C6CF.7030100@yahoo.com>
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
To: autofs@linux.kernel.org


Maps are where you get your mount information from. You could be using any
map and mounting a kind of share (nfs/smbfs).

If you use local files for specifying which server/share to mount, then
you are using file maps.

	<< ryan

On Fri, 14 Nov 2003, Alexander Macdonald wrote:

> Ian Kent wrote:
>
> >The autofs4-2.4 module build kit or the patches contained in it or the
> >patches contained in autofs-4.1.0-beta3 can give you this for some of the
> >maps. NIS, LDAP and file maps work at the moment.
> >
> >I's in the expected place on kernel.org.
> >
> >
>
> not sure what you mean by file maps, but I'm trying to mount samba and
> nfs shares so i guess I'm out of luck...
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
