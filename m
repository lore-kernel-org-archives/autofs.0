From: Paul Raines <raines@nmr.mgh.harvard.edu>
Subject: Re: rm hangs on symlinks to down mount points
Date: Tue, 6 Jan 2004 11:23:42 -0500 (EST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0401061115160.16793-100000@gate.nmr.mgh.harvard.edu>
References: <3FF21106.4000907@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FF21106.4000907@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org

I am now in one of the unmountable mount situation I described
before:

[root@gate /root]# umount /autofs/space/meso_013
umount: /autofs/space/meso_013: device is busy
[root@gate /root]# umount -f /autofs/space/meso_013
umount2: Device or resource busy
umount: /autofs/space/meso_013: Illegal seek
[root@gate /root]# find /proc -lname '*meso*' 2>&1 | grep -v 'No such'
[root@gate /root]# fuser -m /autofs/space/meso_013
/autofs/space/meso_013: Stale NFS file handle
[root@gate /root]# ps auxw | grep auto
root       650  0.0  0.1  1612  580 ?        S     2003   0:02 
/usr/sbin/automount /autofs/space yp auto.space intr,rw,hard,nodev,rs

As you can see, no process is advertising itself as one that is
keeping the mount "busy".  So I see nothing I can kill.  There
are no automount subprocesses, just the parent one.  I can try 
stopping that but I have over 30 users on the system now and I
would rather not cause an interruption.

Is there any other solution?  Any better way to hunt for processes
that are keeping a mount busy?

-- 
---------------------------------------------------------------
Paul Raines                   email: raines@nmr.mgh.harvard.edu
MGH/MIT/HMS Athinoula A. Martinos Center for Biomedical Imaging
149 (2301) 13th Street        Charlestown, MA 02129	USA   
