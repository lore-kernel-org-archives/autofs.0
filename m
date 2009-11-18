From: Ian Kent <raven@themaw.net>
Subject: Re: ls command fails to properly list contents of
	directories
Date: Wed, 18 Nov 2009 22:19:08 +0800
Message-ID: <4B04025C.9020009@themaw.net>
References: <2590cb1a0911052219i260a3c07ib57edd321f21b4be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <2590cb1a0911052219i260a3c07ib57edd321f21b4be@mail.gmail.com>
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
To: Rezk Mekhael <rezk.mekhael@gmail.com>
Cc: autofs@linux.kernel.org

Rezk Mekhael wrote:
> Hi all,
> I have a question about automout over linux:
> Why Standard UNIX LS command  fails to properly list contents of directories
> on *untriggered* automounts using nfs?

This is normal and intentional.
Assuming you are using version 5, see configuration entry BROWSE_MODE
and auto.master(5) and note that the distributed configuration sets this
to "no" to match the version 4 default.

Ian
