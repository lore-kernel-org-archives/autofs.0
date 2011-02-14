From: Masatake YAMATO <yamato@redhat.com>
Subject: Re: [PATCH 1/3] Add dir map-type.
Date: Mon, 14 Feb 2011 22:23:57 +0900 (JST)
Message-ID: <20110214.222357.864020142310384093.yamato@redhat.com>
References: <20110211.052743.503074989287605879.yamato@redhat.com>
	<1297393464.2757.3.camel@perseus> <1297394832.3844.6.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1297394832.3844.6.camel@perseus>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

Thank you for commenting.

> On Fri, 2011-02-11 at 11:04 +0800, Ian Kent wrote:
>> On Fri, 2011-02-11 at 05:27 +0900, Masatake YAMATO wrote:
>> > No comment?
>> > 
>> > I've got one comment privately: use a suffix instead of prefix "auto." 
>> > to filter included files. I'm reflected the comment in my local source
>> > tree. Before posting it to this list, I'd like to get more feedbacks.
>> 
>> I seem to have missed this, but looking at it, it doesn't appear to
>> adhere to the semantics of + included maps. How does this detect when a
>> map of the same name is included so that the files source can be skipped
>> and the next nss source used instead?
>>  
>> > 
>> > Masatake YAMATO
>> > 
>> > > `dir' map-type is for including files under a directory into master
>> > > map.
>> > > `file' map-type can be used for including a file with + notation like:
>> > > 
>> > >        +/etc/auto.mine
> 
> Within a file map (only) any map type can be + included by giving just
> the map name and setting nsswitch to the sources you want to look in. If
> a file map of the same name as the included map exists, at the moment
> that means within /etc, then it will be used, if not then the next
> nsswitch source will be consulted. If a map of the same name as the +
> included map is included then the nsswitch files source will be ignored
> and subsequent sources consulted.
> 

I've not understood the relationship between my patch and your comment well yet.
Could you give me a concrete example?

I'm not convinced that I understood your comment. But I guess you suggest
inconsistent evaluation of following autom.master:

    $ cd /etc; cat auto.master
    +file:/etc/autofs.d/auto.foo
    +dir:/etc/autofs.d

In this case auto.foo will be read as a file type master source twice:
once via +file line of auto.master and once via +dir line of auto.master.

Is my guessing correct?
(In my patch `dir' type is not added to `nss_source' of autofs/lib/nss_parse.y.)

In addition I have a question about autofs (without my patch).
Consider following auto.master with no nsswitch setting:

    $ cd /etc; cat auto.master
    +file:/etc/auto.bar
    +auto.bar

In this case my understanding is that /etc/auto.bar will be read twice as a 
file type source. Is my understanding right?

Masatake YAMATO
