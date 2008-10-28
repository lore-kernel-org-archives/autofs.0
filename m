From: Ian Kent <raven@themaw.net>
Subject: Re: expire_indirect errors in the syslog
Date: Tue, 28 Oct 2008 17:04:35 +0900
Message-ID: <1225181075.2938.97.camel@zeus.themaw.net>
References: <4906C365.8030209@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4906C365.8030209@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Tue, 2008-10-28 at 08:46 +0100, Ondrej Valousek wrote:
> Hi all,
> 
> I am seeing quite lot of following messages in the syslog:
> Oct 21 02:17:05 ara automount[3181]: expire_indirect: fstat failed: Bad
> file descriptor
> 
> On RHEL-5.2, last updates, autofs-5.0.1-0.rc2.88.
> I have seen some discussion on the net (bug #448038) regarding this
> error and what is common is, that my  NFS server is using the "nohide"
> option.
> 
> Question - is this bug dangerous or not? Is there any resolution to
> this? Recently I have experienced our logon server instability (Gnome
> session frozen) due to a problem with gnome-vfs so I do not know if this
> is related....

Ummm .. it could be but should only be an issue when related to the
"nohide" handling.

Log a bug and get hold of rev 101 and see how things go.

Ian
