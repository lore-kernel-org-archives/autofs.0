From: Ian Kent <raven@themaw.net>
Subject: Re: fsck and already mounted filesystems
Date: Wed, 26 May 2004 13:24:58 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405261319580.20880@wombat.indigo.net.au>
References: <200405242236.i4OMaWqR027104@pookie.nersc.gov>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200405242236.i4OMaWqR027104@pookie.nersc.gov>
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

On Mon, 24 May 2004 canon@nersc.gov wrote:

> 
> Greetings,
> 
> We perform multiple mounts of local file systems for
> use in a chroot environment.  It looks like this latest
> autofs breaks this since the fsck fails.  The fix
> would be to skip the fsck if the file system is already
> mounted.  There is code in libext2fs that does this.
> I can propose a patch if it would be helpful.
>

Could you be a little more specific regarding the version please.

I assume you mean 4.1.2 -> 4.1.3. Did it work before that. If so how far 
back?

The main change here was a correction to spawn function parameters when 
calling fsck.

Ian
