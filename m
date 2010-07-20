From: "michael@kmaclub.com" <michael@kmaclub.com>
Subject: Re: Making "verbose" mode a little less verbose
Date: Tue, 20 Jul 2010 07:50:22 -0700
Message-ID: <4C45B7AE.7050906@kmaclub.com>
References: <20100706181115.GA23693@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20100706181115.GA23693@libre.l.ngdn.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

On 07/06/2010 11:11 AM, Leonardo Chiquitto wrote:
> Hello AutoFS developers,
>
> I'm trying to improve the usefulness of "verbose" logs for a customer.
> The problem they currently face can be summarized as: they need some
> messages that are only logged with DEFAULT_LOGGING="verbose" (or debug),
> but enabling the verbose mode on busy servers (hundreds of users and
> AutoFS mount points) causes a significant traffic increase on their
> syslog infrastructure.
>
> My first idea was to introduce a new log level ("normal") and move the
> most important messages from "verbose" to "normal", but I realized later
> that this would require some redesign to allow some info() messages to
> be printed only on "verbose" mode. Since this would be more intrusive,
> I decided to go with a simpler proposal: move some "verbose" messages
> to "debug" level. Here are some examples of messages that would be
> demoted to debug (prefixed with -):


Hi Ian and Leonardo,

I am seeing a similar issue with my clients as well.  Autofs logs quite 
a bit of data and I would like to reduce it.  Turning off logging isn't 
an option since it is useful for debugging sporadic issues.

Would this patch be considered?  Is there some other way to reduce 
logging while still retaining enough to debug problems ( where running 
in debug mode isn't possible )?

Michael
