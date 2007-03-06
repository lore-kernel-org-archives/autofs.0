From: Ian Kent <raven@themaw.net>
Subject: Re: direct mount from NFS-mounted directories issue
Date: Wed, 07 Mar 2007 01:57:12 +0900
Message-ID: <1173200232.3629.27.camel@raven.themaw.net>
References: <45ED676E.8020904@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45ED676E.8020904@inria.fr>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Tue, 2007-03-06 at 14:06 +0100, Guillaume Rousse wrote:
> A direct mount which mount point is itself located on a NFS mount
> does'nt work, with the following error message on launch:
> Mar  6 14:05:21 stalingrad automount[23355]: do_mount_autofs_direct:
> failed to create mount directory /home/members/rousse/test

Does the mount point directory already exist within the remote NFS
filesystem?

If not then create it.

This behavior was changed because the NFS client in recent kernels
return EACCESS before it returned EEXIST. It would have been fine to
just use stat(2) and then create the mount point directory but that
attracted much criticism regarding the security aspects of "root" owned
code to attempting to create directories on a remote NFS server. And so
this is the way it is now.

> >From the mandriva user that reported this issue, it worked with previous
> release. Full story at http://qa.mandriva.com/show_bug.cgi?id=28646

Indeed it probably did work a little while ago.
Sorry for the inconvenience.

Ian
