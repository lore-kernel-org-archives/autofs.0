From: Ian Kent <raven@themaw.net>
Subject: Re: fsck and already mounted filesystems
Date: Fri, 28 May 2004 10:13:27 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405281012410.6708@wombat.indigo.net.au>
References: <200405271510.i4RFAqxp019860@pookie.nersc.gov>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200405271510.i4RFAqxp019860@pookie.nersc.gov>
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
To: canon@nersc.gov
Cc: autofs@linux.kernel.org

On Thu, 27 May 2004 canon@nersc.gov wrote:

> 
> Sorry about the latency in my reply.
> 
> I first noticed this problem on the autofs distributed
> with FC2 (4.1.2).  I tested 4.1.3 and it didn't appear to
> fix it (I had noticed the patch).  Version 3.1.7 worked okay,
> probably because it didn't attempt an fsck before mounting
> ext2/3 file systems.  You can easily test it by creating
> a map like such...
> 
> cat > /etc/auto.local << EOF
> root      -fstype=ext3          :/dev/<root partition>
> EOF
> 
> automount /local file /etc/auto.local
> 
> Attempting to access /local/root will fail because the
> fsck failed since the file system is already mounted.

I can see how this happens.

I'll see what I can do.

Ian
