From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: NIS maps loading.
Date: Tue, 25 Jan 2005 17:50:45 +0100
Message-ID: <20050125165045.GA8642@uio.no>
References: <41F56D27.1080005@redhat.com>
	<Pine.LNX.4.58.0501250904250.21644@wombat.indigo.net.au>
	<20050125121827.GE2032@ba.issia.cnr.it>
	<16886.26557.799629.351909@segfault.boston.redhat.com>
	<20050125155021.GC8093@ba.issia.cnr.it>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050125155021.GC8093@ba.issia.cnr.it>
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Tue, Jan 25, 2005 at 04:50:21PM +0100, Francesco P. Lovergine wrote:
>> The kernel patch you want is also listed on the website above.  You could
>> also just wait for 4.1.4 (or the beta version thereof).
> Uhm, probably we missed that in current debian. Isn't it the same of FC3?

Probably we missed it, yes. I'm still on semi-vacation (although I'm home from
the USA, it's hard to do extensive testing without a Linux system :-) ), so I
guess I'll simply wait for 4.1.4, which should be a largely problem-free
update for us anyhow.

BTW, current Debian versions has fixes for whitespace in parse_sun.c (also
for non-multimaps); are those fused upstream yet?

/* Steinar */
-- 
Homepage: http://www.sesse.net/
