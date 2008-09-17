From: Joe Pruett <joey@clean.q7.com>
Subject: Re: latest autofs from centos 4
Date: Wed, 17 Sep 2008 07:15:02 -0700 (PDT)
Message-ID: <alpine.LRH.2.00.0809170712020.14205@q7.q7.com>
References: <alpine.LRH.2.00.0809161716010.13560@q7.q7.com>
	<1221621937.3001.3.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1221621937.3001.3.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Wed, 17 Sep 2008, Ian Kent wrote:

> On Tue, 2008-09-16 at 17:22 -0700, Joe Pruett wrote:
>> it looks like some recent changes to both autofs v4 and v5 has caused the
>> siogcifconf buffer to be only 128 bytes.  this means that on our servers,
>> it can't correctly match a local address since that is only enough room
>> for 3 addresses and we're in the middle of a renumbering so we have 5-10
>> addresses per machine.  this was working fine until i just updated to
>> centos 4.7.  from looking at the code, it looks like someone created a
>> MAX_IF_BUF #define at 2048, but didn't use it for the ioctl call.  is that
>> a mistake?
>>
>> i'll try a patched rpm locally and make sure this is the source of my
>> woes.
>
> Yeah, known issue.
> It's resolved in RHEL-5.3.

it seems like it got worse with the latest 4.7 stuff.  maybe i just didn't 
notice machines talking to themselves over nfs previously.  has it always 
been 128 bytes?

i'm concerned about the patch for my web hosting machine.  right now it 
has over 1024 interfaces.  the amount of time all that malloc/free is 
going to take for every mount seems pretty expensive.  would any kind of 
caching make sense?
