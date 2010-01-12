From: Ian Kent <raven@themaw.net>
Subject: Re: Missing spin_lock(&dcache_lock)
Date: Tue, 12 Jan 2010 22:17:09 +0800
Message-ID: <4B4C8465.6050100@themaw.net>
References: <20100111115257.GA3211@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20100111115257.GA3211@libre.l.ngdn.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

On 01/11/2010 07:52 PM, Leonardo Chiquitto wrote:
> Hello,
> 
> If I compare the 2.6.18 and 2.6.20 kernel trees after applying,
> respectively, autofs4-2.6.18-v5-update-20090903.patch and
> autofs4-2.6.20-v5-update-20090903.patch, I can understand most of the
> differences, but this specific chunk seems strange to me:

Oops.

I'll have a look but, from memory, that lock should be present.

The back porting of changes to older kernels gets harder and more error
prone as time passes.

> 
> diff -Nurp linux-2.6.18.8/fs/autofs4/root.c linux-2.6.20.21/fs/autofs4/root.c
> --- linux-2.6.18.8/fs/autofs4/root.c	2010-01-08 13:34:35.000000000 -0200
> +++ linux-2.6.20.21/fs/autofs4/root.c	2010-01-11 09:00:28.000000000 -0200
> @@ -91,6 +91,7 @@ static int autofs4_dir_open(struct inode
>  	 * autofs file system so just let the libfs routines handle
>  	 * it.
>  	 */
> +	spin_lock(&dcache_lock);
>  	if (!d_mountpoint(dentry) && __simple_empty(dentry)) {
>  		spin_unlock(&dcache_lock);
>  		return -ENOENT;
> 
> Was this line left out by mistake? If yes, can you please consider the patch
> below?
> 
> Thanks,
> Leonardo
> 
> Index: autofs/patches/autofs4-2.6.18-v5-update-20090903.patch
> ===================================================================
> --- autofs.orig/patches/autofs4-2.6.18-v5-update-20090903.patch
> +++ autofs/patches/autofs4-2.6.18-v5-update-20090903.patch
> @@ -103,6 +103,7 @@
>  +	 * autofs file system so just let the libfs routines handle
>  +	 * it.
>  +	 */
> ++	spin_lock(&dcache_lock);
>  +	if (!d_mountpoint(dentry) && __simple_empty(dentry)) {
>   		spin_unlock(&dcache_lock);
>  -
> Index: autofs/patches/autofs4-2.6.19-v5-update-20090903.patch
> ===================================================================
> --- autofs.orig/patches/autofs4-2.6.19-v5-update-20090903.patch
> +++ autofs/patches/autofs4-2.6.19-v5-update-20090903.patch
> @@ -1041,6 +1041,7 @@
>  +	 * autofs file system so just let the libfs routines handle
>  +	 * it.
>  +	 */
> ++	spin_lock(&dcache_lock);
>  +	if (!d_mountpoint(dentry) && __simple_empty(dentry)) {
>   		spin_unlock(&dcache_lock);
>  -
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
