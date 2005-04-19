From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: replicated mounts patch
Date: Tue, 19 Apr 2005 15:07:33 -0400
Message-ID: <16997.22261.125769.972792@segfault.boston.redhat.com>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net>
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
	<1113933871.1274.56.camel@barsoom.rdu.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1113933871.1274.56.camel@barsoom.rdu.redhat.com>
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
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org, raven@themaw.net

==> Regarding Re: [autofs] replicated mounts patch; Jeffrey Layton <jtlayton@poochiereds.net> adds:

jtlayton> On Tue, 2005-04-19 at 12:58, raven@themaw.net wrote:
>> Does the is_local_addr function work correctly for multi-homed hosts?

jtlayton> I changed the name of the is_local_addr() function to
jtlayton> is_bind_addr(), but otherwise left it more or less untouched. I
jtlayton> did this in anticipation that we will eventually want to make an
jtlayton> is_local_addr() function that does the 'subnet' check that the
jtlayton> manpage claims. So, the short answer is, yes -- it should work
jtlayton> for multi-homed hosts since it essentially does what the original
jtlayton> code does here.

>> Does the parse_mount_string work for something like: "host1 , host2
>> ,host3, host4:/this/dir"?

jtlayton> Yes. I've verified that it does. It even works for relatively
jtlayton> strange stuff like:

jtlayton> host1(1),host2:/this/dir host3(5):/that/dir

jtlayton> Unspecified weights get assigned the value 65535.

From the docs:

  The numbers in parentheses() indicate a weighting. Servers without a
  weighting have a value of zero (most likely to be selected). The higher the
  weighting value, the less chance the server will be selected.

Please change accordingly.

-Jeff
