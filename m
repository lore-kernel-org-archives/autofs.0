From: "Oliver Weinmann" <oliver.weinmann@vega.de>
Subject: Re: Patching Autofs on
	SLES9(autofs-4.1.3-included-maps.patch)
Date: Tue, 22 Jun 2010 10:26:35 +0200
Message-ID: <577798A82D8C2746B9461A64C5F4562802383A8C@GEDACV2>
References: <AcsMaytc7B8+ciJHQp6E6oe4Nl+Pjg==><577798A82D8C2746B9461A64C5F4562802383A50@GEDACV2><AANLkTimHtsxBHJIPgJh1SNbCIL8mpMyyuGgfOSacHfSp@mail.gmail.com>
	<577798A82D8C2746B9461A64C5F4562802383A8B@GEDACV2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <577798A82D8C2746B9461A64C5F4562802383A8B@GEDACV2>
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

The problem is also not fixed on SLES10 SP3. I tried to find the
autofs-4.1.3-included-maps.patch on google but no success.

Regards,
Oliver

-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of Oliver Weinmann
Sent: Montag, 21. Juni 2010 14:09
To: Leonardo Chiquitto
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Patching Autofs on
SLES9(autofs-4.1.3-included-maps.patch)

Hi Leonardo,

I was able to build autofs4 from sles10 sp3 32bit on SLES9 SP4, but
unfortunately it doesn't work. I'm not 100% sure if the problem was
fixed in the SLES10 SP3 release or if it is just not working on SLES9
for another reason. I will now install a SLES10 SP3 32Bit to check
wether the problem is fixed or not. If the problem is fixed the problem
under SLES9 must be different.

-----Original Message-----
From: Leonardo Chiquitto [mailto:leonardo.lists@gmail.com]
Sent: Freitag, 18. Juni 2010 18:20
To: Oliver Weinmann
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Patching Autofs on SLES9
(autofs-4.1.3-included-maps.patch)

Hello Oliver,

AutoFS 5 won't work on SLES 9 because it requires Kernel changes that
were not back ported to 2.6.5. The first version of SLES to support
AutoFS 5 is SLES 10-SP2.

If you really can't upgrade to SLES 10-SP3 or SLES 11-SP1, your best bet
is to get autofs-4.1.4 source RPM from SLES 10-SP3 and rebuild it on
SLES 9. The problem you reported is most likely already fixed on that
version.

Hope it helps,
Leonardo

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email
______________________________________________________________________

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email
______________________________________________________________________
