From: Ian Kent <raven@themaw.net>
Subject: Re: Re: autofs and smb shares
Date: Mon, 5 Apr 2004 20:59:21 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404052056510.3372@raven.themaw.net>
References: <001601c41955$830a9580$51004701@mobylines.it>
 <Pine.LNX.4.58.0404032101140.23951@raven.themaw.net>
 <003f01c41ae5$2c910130$3801010a@mobylines.it>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <003f01c41ae5$2c910130$3801010a@mobylines.it>
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
To: "Amodiovalerio [Hypo] Verde" <valerio.verde@moby.it>
Cc: autofs@linux.kernel.org

On Mon, 5 Apr 2004, Amodiovalerio [Hypo] Verde wrote:

> I applied the patch, but it doesn't work.
> 
> I confirm that there is a EBADSLT here. When I disable the share I got ( and
> I also check via errno )
> 
> "ls: .: Invalid slot"
> 
> Tried to change
> 
>  if (!status || (is_smbfs && sav_errno == EIO )) {
> 
> with
> 
>  if (!status || (is_smbfs && ( sav_errno == EIO || sav_errno == EBADSLT ) ))
> {
> 
> and it works.

OK I'll add that. Must be related to the version of kernel or the smb 
mount.

I must say that my testing showed some problems when I tried to break it 
so lets keep an eye on it.

Ian
