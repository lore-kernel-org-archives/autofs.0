From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Mon, 19 Jan 2009 11:03:25 +0900
Message-ID: <1232330605.3136.7.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1232066406.3166.28.camel@zeus.themaw.net>
	<1232070195.3166.36.camel@zeus.themaw.net>
	<408431290901151959o7c504c79k88681dddb468359f@mail.gmail.com>
	<1232079714.3166.56.camel@zeus.themaw.net>
	<408431290901152204i8d2da71vbf8ee5f2e2f84fa@mail.gmail.com>
	<1232087057.3166.88.camel@zeus.themaw.net>
	<1232087952.3166.98.camel@zeus.themaw.net>
	<408431290901170911q1af268b1o5576f46e0bee2129@mail.gmail.com>
	<1232249174.3106.5.camel@zeus.themaw.net>
	<408431290901181728u5b01c262u1b2640595deaac95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901181728u5b01c262u1b2640595deaac95@mail.gmail.com>
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
To: Paul Wankadia <junyer@google.com>
Cc: autofs@linux.kernel.org

On Mon, 2009-01-19 at 12:28 +1100, Paul Wankadia wrote:
> On Sun, Jan 18, 2009 at 2:26 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         
>         > Is there a design document for autofs v5 that you're
>         permitted to
>         > share?
>         
>         
>         There isn't, but even of there were it wouldn't have a level
>         of detail
>         that would be useful in cases like this and if it did it would
>         have
>         become hopelessly out of date as time has passed.
>         
>         However, the attached pdf, written by Jeff and myself, has a
>         high level
>         overview of v5 and what it seeks to achieve.
> 
> Cool, thanks.
> 
> It's just that your earlier comment regarding a concurrency issue led
> me to wonder about the use of Pthreads. In particular, I'm not sure
> what the rationale was, but I'd also like to understand the control
> flow, so that's why I was interested in a design document of some
> sort.

Right.

One of the things that v5 does is to move the master map parsing out of
the init script and into the daemon itself. That means that the daemon
then has to manage each of the master map mounts as well. Using
individual sub-processes has a whole set of problems related to the
supervising process communicating with and knowing the state of those
sub-processes so v5 changed to a threaded model which of course has it's
own set of difficulties.

Ian
