From: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: Code cleanup
Date: Fri, 28 Jul 2006 11:25:48 +0200
Message-ID: <1154078748.3094.7.camel@gimli.at.home>
References: <20060714035857.GM29064@mail.iSKUNK.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060714035857.GM29064@mail.iSKUNK.ORG>
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
To: autofs@linux.kernel.org

On Thu, 2006-07-13 at 23:58 -0400, Daniel Richard G. wrote:
[...]
> (various files):
> 
> * Don't use "#if WITH_FOO", as this produces a warning if WITH_FOO is 
>   undefined. Use "#ifdef".

Personally I would define them to always have a value (be it "0" or "1"
for "false" and "true") - and set them correctly in a .h file or
Makefile - so you catch typos using them.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services
