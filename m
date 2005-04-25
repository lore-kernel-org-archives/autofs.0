From: raven@themaw.net
Subject: Re: Bug#304245: patch - NFS mounts occasionally fail
Date: Mon, 25 Apr 2005 09:27:20 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504250924220.1674@donald.themaw.net>
References: <20050417154240.GA17232@uio.no>
	<20050417181827.GA13101@vision.ime.usp.br>
	<Pine.LNX.4.62.0504182142090.14946@donald.themaw.net>
	<42640E89.7090005@redhat.com>
	<Pine.LNX.4.62.0504241602310.18935@donald.themaw.net>
	<Pine.LNX.4.62.0504241728230.20970@donald.themaw.net>
	<20050424161805.GA15363@vision.ime.usp.br>
	<Pine.LNX.4.62.0504250202400.5096@donald.themaw.net>
	<20050425002230.GA29407@vision.ime.usp.br>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050425002230.GA29407@vision.ime.usp.br>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Daniel Andre Vaquero <daniel@vision.ime.usp.br>
Cc: autofs mailing list <autofs@linux.kernel.org>, Chris Feist <cfeist@redhat.com>

On Sun, 24 Apr 2005, Daniel Andre Vaquero wrote:

> On Mon, Apr 25, 2005 at 02:10:14AM +0800, raven@themaw.net wrote:
>> On Sun, 24 Apr 2005, Daniel Andre Vaquero wrote:
>>
>>> I would also suggest a change in the name of this function to something
>>> like is_replicated_entry. Multi-mounts and replicated mounts are
>>> different things, and in this case it could confuse the reader.
>>
>> Perhaps. But they are handled by the same code.
>> The simple replicated mount entry is a special case of a multi-mount
>> entry as far as the code is concerned. At least that's the way it is now.
>
> Sorry, I didn't see that it is now also being used in parse_sun.c. Then
> I agree that it is OK.

I've removed those patches just now.

After thinking about it I think you were right.
I'm going to leave these tests seperate and rename the test as you 
suggest.

>
> I have tested version 4.1.4 plus the three new patches from kernel.org,
> and found a bug when using bogus names in multi-mounts. The test case is:
>
> /etc/auto.testing
>
> foo     -ro,hard,intr \
>        /dir/bar        bogus:/usr/src \
>        /dir/baz        morebogus:/usr/share/doc
>
> When the function get_best_mount tries to resolve the bogus names, there is a
> host lookup failure. Then it returns the winner as local, and automount does
> a mount --bind. But the correct behaviour would be a mount failure.
>
> The corresponding log entries follows attached. I have also made and tested
> a little patch to fix it (and a brace missing in
> autofs-4.1.4-multi-parse-fix.patch), that is attached as well.

Thank you very much for that.
I will attend to it right now.

Ian
