From: Gerald Teschl <gerald.teschl@univie.ac.at>
Subject: Re: Re: autofs RFE
Date: Wed, 10 Dec 2003 09:45:45 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FD6DD39.2000409@univie.ac.at>
References: <Pine.LNX.4.44.0312081124260.15293-100000@keen.esi.ac.at>
	<3FD6C1F7.90301@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FD6C1F7.90301@zytor.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>

H. Peter Anvin wrote:

> Gerald Teschl wrote:
>
>>
>> The ideal solution would be to make the mount call as the user 
>> requesting
>> the mount, but if I understand you right, this is to complex to find 
>> out.
>>
>
> Absolutely not!  It would let a remote user "hijack" your media! 

No, because mount would not allow the command to succeed in this case
(otherwise the user could do an ordinary mount as well).

Gerald
