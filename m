From: "Amodiovalerio [Hypo] Verde" <valerio.verde@moby.it>
Subject: Re: Re: autofs and smb shares
Date: Mon, 5 Apr 2004 10:08:26 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <003f01c41ae5$2c910130$3801010a@mobylines.it>
References: <001601c41955$830a9580$51004701@mobylines.it>
	<Pine.LNX.4.58.0404032101140.23951@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Class: urn:content-classes:message
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

I applied the patch, but it doesn't work.

I confirm that there is a EBADSLT here. When I disable the share I got ( and
I also check via errno )

"ls: .: Invalid slot"

Tried to change

 if (!status || (is_smbfs && sav_errno == EIO )) {

with

 if (!status || (is_smbfs && ( sav_errno == EIO || sav_errno == EBADSLT ) ))
{

and it works.


Amodiovalerio [Hypo] Verde


> > I've solved the problem ( I hope ) just forcing the umount when the
fstat
> > fails cause of errno like EBADSLT ( that's what I got when the share is
not
> > more available ).
>
> I don't see the EBADSLT here. I see an EIO.
>
> >
> > Maybe it's safe to umount the dir without doing a fstat at all.
>
> Don't like that much. The lstat probably causes smbfs to return EIO
> instead of EBADSLT.
>
> If you are keen, please try this patch and let me know how you go.
>
> Ian
