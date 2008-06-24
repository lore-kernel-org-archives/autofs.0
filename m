From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Tue, 24 Jun 2008 20:18:15 +0100
Message-ID: <3F93639B-02A9-4809-A26B-84CD9AA690BF@cam.ac.uk>
References: <8332BEF1-7FA5-434F-B444-9F8820A61B83@cam.ac.uk>
	<1213969464.2971.107.camel@raven.themaw.net>
	<5A1DEB9E-FD94-455E-AB89-05D9E74084B5@cam.ac.uk>
	<1213974299.4975.15.camel@raven.themaw.net>
	<095037D1-F2F1-4A08-A6D2-841C22D8BC5C@cam.ac.uk>
	<1213975734.4975.17.camel@raven.themaw.net>
	<485BE2E6.9080509@zytor.com>
	<1213986137.4975.39.camel@raven.themaw.net>
	<485BFF00.7020205@zytor.com>
	<1214016215.4975.50.camel@raven.themaw.net>
	<485C834C.6010507@zytor.com>
	<1214023459.4975.90.camel@raven.themaw.net>
	<alpine.LSU.1.10.0806211007570.22566@hermes-1.csi.cam.ac.uk>
	<1214186003.3098.10.camel@raven.themaw.net>
	<alpine.LSU.1.10.0806230318150.22566@hermes-1.csi.cam.ac.uk>
	<485EF785.3020308@zytor.com>
	<8109C868-FFB0-4AF3-A667-FEA9F6693558@cam.ac.uk>
	<Pine.LNX.4.64.0806231735200.5058@xena.cft.ca.us>
	<D5877985-8F27-4B28-B942-DF54B9C82D29@cam.ac.uk>
	<Pine.LNX.4.64.0806241147070.4023@xena.cft.ca.us>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0806241147070.4023@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>, Unix Support <unix-support@ucs.cam.ac.uk>, "H. Peter Anvin" <hpa@zytor.com>

Hi,

On 24 Jun 2008, at 19:55, Jim Carter wrote:
> On Tue, 24 Jun 2008, Anton Altaparmakov wrote:
>>> This problem is interesting: how would you do this while using the
>>> multi-thread capability of autofs version 5?  Here's how far I  
>>> got.  First,
>>> we're not going to mount anything at login time; we're going to  
>>> mount the
>>> homedir the first time it's referenced, which on my system would be
>>> slightly before logging in is finished (to check the ssh key in the
>>> homedir).
>>
>> Note this is not possible for us.  You cannot use SSH-keys when the  
>> home
>> directory is on a Netware server because you need the user's  
>> password to be
>> able to mount the home directory, there is no way to perform the  
>> mount before
>> asking the user for their password.
>
> Oh, I didn't mean that you should use ssh authentication (in the  
> sense that
> if the given password decrypts the ssh private key, that's  
> sufficient to
> authenticate the user), I meant that we always load the keys into an  
> agent
> process if existing, which requires automounting the homedir partway
> through PAM processing before the user is fully logged in.
>
> Are you saying that publickey authentication in ssh is desired by  
> users but
> is not feasible, because the plaintext password is required to mount  
> the
> homedir to read the public key?  I guess that's right, when the  
> homedir is
> on NCP or CIFS.

Yes, that is correct.  Users want it and we can't give it to them as  
we cannot read their ~/.ssh directory contents until we have asked for  
their plaintext password and used it to authenticate to the netware  
server.

Best regards,

	Anton

>>> Warning: before deploying a submount-based scheme in production,  
>>> watch for
>>> a resolution of the internal locking (mutex) issue that's so  
>>> bedeviling me.
>>
>> Could you elaborate on this?  What issue are you seeing?  Thanks a  
>> lot in
>> advance!
>
> Ian Kent described it pretty well in his reply.  The thread that's  
> trying
> to mount a directory just hangs, and any further reference to that dir
> piles up waiting forever for the mount to finish.  At least the client
> process can be killed.

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
