From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: auto.net gets a key with a path under SLES9.
Date: Tue, 15 Nov 2005 09:31:19 -0500
Message-ID: <17273.61751.864306.585017@segfault.boston.redhat.com>
References: <4378ED9A.6090903@deragon.biz>
	<Pine.LNX.4.58.0511150826030.27505@wombat.indigo.net.au>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0511150826030.27505@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] auto.net gets a key with a path under SLES9.; Ian Kent <raven@themaw.net> adds:

raven> On Mon, 14 Nov 2005, Hans Deragon wrote: Thanks for reporting this
raven> Hans.

>> Greetings.
>> 
>> 
>> I compiled autofs 4.1.4 for SuSE Linux Enterprise Server 9 (SLES9). I
>> did found a little problem with auto.net.  The original code has:
>> 
>> key=$1
>> 
>> However, under SLES9, in my network environment, $key can be of the form
>> "server/something[/otherthing]*", which is wrong.  $key should only be a
>> server name.  I fixed the problem with:
>> 
>> key=`echo $1 | perl -wp -e 's%^(\w+)(\/?.+)*$%$1%;'`
>> 
>> My fix removes any path after the server name.

raven> Interesting. I'm not sure why that's happening either.

>> Exactly why automount passes a server name containg some path is unclear
>> for me.  But I wanted to report this here.  If other suffer from this,
>> you might want to consider some fix like mine (maybe using sed which is
>> more standard).

raven> Yep. Sounds like a good idea.

raven> I'll put it on the queue of stuff for 4.1 so I can do it when I
raven> eventually get back to it.

Ian, this sounds more like papering over the real problem to me.  Do you
agree?  I'd like to see some debug output.

-Jeff
