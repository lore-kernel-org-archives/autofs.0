From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Exporting UID to userspace?
Date: Mon, 07 Jun 2004 12:06:40 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40C49290.8060309@sun.com>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841A4@frodo.avalon.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <E1B7C89B8DCB084C809A22D7FEB90B3841A4@frodo.avalon.ru>
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
To: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dimitry V. Ketov wrote:
>
>>-----Original Message-----
>>From: Robin Rosenberg [mailto:robin.rosenberg.lists@dewire.com]
>>
>>On Saturday 05 June 2004 17.52, raven@themaw.net wrote:
>>..
>>
>>>How will you provide a consistent Unix UID <-> Windows UID mapping?
>>>And on multiple machines for the same user, over OS re-install? Ian
>>
>>cases you can use a mapping table in the script that
>>automount calls. Autofs should just provide the local uid,gid
>>from the calling process.
>
>
> Yes, you're definitely right. In fact I want this finctionality just for
> 'program' maps, lets say UID, GID and supplementary GIDs like a second,
> third, so on ... parameters to the map script.
>

My real problem with this RFE is that there is no indication on how you
are planning to acquire the user credentials.

For instance:
- - how are you going to acquire terminal information with just a uid/gid
pair?
- - how are you going to handle the case where there was no terminal?
- - what about when there was no terminal, but there were X resources
available? (kernelspace wouldn't know anything about this at all..)


Shouldn't this RFE also include some proposal for how you are going to
ensure that only a single uid ever attempts access to the automounted
directory as well? (if needed?)


The current work-around is to have the credentials supplied by the map
itself.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxJKPdQs4kOxk3/MRAuX9AJ9FVcGKhOMzPLFkHspT02CiattpMQCdH56m
/AkQpZ1/5XmoGL+9cJ8poE0=
=9W5D
-----END PGP SIGNATURE-----
