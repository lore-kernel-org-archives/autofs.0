From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Exporting UID to userspace?
Date: Wed, 09 Jun 2004 14:44:25 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40C75A89.4020002@sun.com>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841AA@frodo.avalon.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <E1B7C89B8DCB084C809A22D7FEB90B3841AA@frodo.avalon.ru>
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
>>-----Original Message-----
>>From: autofs-bounces@linux.kernel.org
>>
>>If the idea is to have a 'Network Neighborhood' inside each
>>user's homedir, you could write an executable map for /home
>
>
> It will hide /home directory content.

No. It wouldn't presuming that your /home subdirs are automounted.  The
script would basically transform map entries like:

mikew	-wsize=32768,rsize=32768  homedirserver:/export/home/mikew

Into:
mikew	-wsize=32768,rsize=32768  homedirserver:/export/home/mikew \
  /NetworkNeighborhood	-fstype=autofs,Duser=mikew /etc/auto_nn

which is a valid multimount and should be handled correctly by automount 4.

>
>
>>(not tested..):
>
>
>>key = shift
>
> Did you mean key=$1 ?
>

Sure.


>
>>entry = `ypcat $KEY -k`
>
> What did you mean for $KEY? What is supposed to assign to the 'entry'
> variable?
>

I meant $key.

>
>>if [ $? == 0 ] ; then
>>   echo $entry " /NetworkNeighborhood -Duser=$key /etc/auto_nn"
>>   exit 0
>>fi;
>>exit 1
>>
>>And then use a auto_nn executable map for generating the
>>Neighborhood contents.
>
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs


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

iD8DBQFAx1qIdQs4kOxk3/MRAk0/AJ0bw0kqFk4qX72h6q+TULhM7qxWYACdENrq
N9IAdc+f5D9aeu2VG3g4DQ8=
=Rp37
-----END PGP SIGNATURE-----
