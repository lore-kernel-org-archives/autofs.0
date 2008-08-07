From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: [PATCH 3/4] autofs4 - devicer node ioctl
	docoumentation.
Date: Thu, 7 Aug 2008 10:38:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0808070944460.18832@simba.math.ucla.edu>
References: <20080807114002.4142.30417.stgit@web.messagingengine.com>
	<20080807114021.4142.39621.stgit@web.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080807114021.4142.39621.stgit@web.messagingengine.com>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 7 Aug 2008, Ian Kent wrote:

> Patch to add documentation for the miscellaneous device module of
> autofs4.

> +AUTOFS_DEV_IOCTL_SETPIPEFD_CMD
> +------------------------------
> +
> +Set the pipe file descriptor used for kernel communication to the daemon.
> +...In order to protect mounts against
> +incorrectly setting the pipe descriptor we also require that the autofs
> +mount be catatonic (see next call).
> +
> +The call requires an initialized struct autofs_dev_ioctl with the
> +ioctlfd field set to the descriptor obtained from the open call...

> +AUTOFS_DEV_IOCTL_CATATONIC_CMD
> +------------------------------
> +
> +Make the autofs mount point catatonic...
> +
> +The call requires an initialized struct autofs_dev_ioctl with the
> +ioctlfd field set to the descriptor obtained from the open call.

I probably have it mixed up, which file descriptor is involved.  Suppose 
the former incarnation of the userspace daemon just dies (kill -9, etc.)  
It will not set any mount points catatonic, so the new incarnation needs 
to do it, like this:

    const char* mtpt = "/net/whatever";
    int len = strlen(mtpt);
    if (len >= PATH_MAX) len = PATH_MAX - 1;
    int fdlist[2];
    int autoFD = open("/dev/autofs", flags);
    struct autofs_dev_ioctl* parms = 
	calloc(1, sizeof(struct autofs_dev_ioctl) + PATH_MAX);
    parms->size = sizeof(struct autofs_dev_ioctl) + len + 1;
    memcpy(parms->path, mtpt, len+1);
    parms->ioctlfd = ?????;
    ioctl(autoFD, AUTOFS_DEV_IOCTL_CATATONIC_CMD, parms);
    socketpair(AF_UNIX, SOCK_DGRAM, 0, fdlist); 
    parms>ioctlfd = fdlist[1];
    ioctl(autoFD, AUTOFS_DEV_IOCTL_SETPIPEFD_CMD, parms);

I don't see how userspace can unilaterally set the mount point catatonic, 
because it needs to set the mount point's file descriptor first, which can 
only be done if the mount point is already catatonic.

Perhaps the documentation could be changed to head off the kind of 
misunderstanding(s) I think I have here.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
