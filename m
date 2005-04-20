From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: replicated mounts patch
Date: Wed, 20 Apr 2005 10:11:49 -0400
Message-ID: <16998.25381.11844.696212@segfault.boston.redhat.com>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net>
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
	<1113941787.1274.84.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.58.0504200922220.7460@wombat.indigo.net.au>
	<1113960613.5879.14.camel@tleilax.poochiereds.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1113960613.5879.14.camel@tleilax.poochiereds.net>
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
Content-Type: text/plain; charset="us-ascii"
To: Jeff Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> Regarding Re: [autofs] replicated mounts patch; Jeff Layton <jtlayton@poochiereds.net> adds:

jtlayton> On Wed, 2005-04-20 at 09:25 +0800, Ian Kent wrote:
>> But, I've had complaints about it in the past.
>> Call it an added feature.
>> 
>> If we choose to not require it we will need to be clear about it in the 
>> doco. 
>> 
>> Personally, I like to be able to add a space after each comma for 
>> readability.
>> 
>> Ian
>> 

jtlayton> It's certainly possible to do it, but will probably require rewriting
jtlayton> the entire parser since my current approach probably won't work if we
jtlayton> allow for it. Using POSIX regex'es might make it easier, but I'll
jtlayton> need to look at how you use them under C.

Bah.  The parser is the source of so much frustration.  When are we going to
rewrite it in Lex/Yacc?  Ian, something to think about for v5?

-Jeff
