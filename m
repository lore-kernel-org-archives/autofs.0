From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH 1/2] Re: [autofs] Bad race condition in the new autofs
 protocol somewhere
Date: Tue, 13 Feb 2007 09:07:27 -0500
Message-ID: <45D1C61F.9090509@redhat.com>
References: <20070207173414.GA64492@dspnet.fr.eu.org> <1170871661.3415.36.camel@raven.themaw.net> <20070207181817.GA75717@dspnet.fr.eu.org> <1170901990.3383.18.camel@raven.themaw.net> <1171262594.18376.13.camel@raven.themaw.net> <20070212135749.GA1681@dspnet.fr.eu.org> <1171327959.3377.3.camel@raven.themaw.net> <20070213085053.GA74257@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750734AbXBMOJI@vger.kernel.org>
In-Reply-To: <20070213085053.GA74257@dspnet.fr.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Olivier Galibert <galibert@pobox.com>, Ian Kent <raven@themaw.net>, "Hack inc." <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org

Olivier Galibert wrote:
> On Tue, Feb 13, 2007 at 09:52:39AM +0900, Ian Kent wrote:
>> Indeed.
>> Which kernel can you use?
>> I believe that 2200 had another problem so can you use an fc5 kernel
>> later than that?
> 
> I've ported your patch to 2257 (nothing special, only moved lines),
> and it seems to work beautifully.  I'm enlarging the testing.
> 

If you get the patches into -stable they will end up in Fedora
kernels automatically. 2288 (based on 2.6.19) is in testing now...
