From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: quota/indirection problem
Date: Mon, 22 Sep 2003 10:39:26 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F6F33CE.7030102@zytor.com>
References: <Pine.LNX.4.58.0309221452400.5636@lucy.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0309221452400.5636@lucy.dcs.qmul.ac.uk>
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
To: Matt Bernstein <mb--autofs@dcs.qmul.ac.uk>
Cc: autofs@linux.kernel.org

Matt Bernstein wrote:
> 
> However, after the timeout kicks in only the "/homes/mb" mount is visible 
> to df--I guess Deep VFS Magick keeps everything internally in order, and 
> my home directory still works fine. BUT..
> 
> Disk quotas for user mb (uid 5154): none
> 
> SO.. I would really like the NFS mount to persist so that the "quota" 
> command produces the output you'd expect.
> 
> Can anyone help? Please.. before our students come back and ruin everything..
> 

Set timeout to zero, so it never times out.

	-hpa
