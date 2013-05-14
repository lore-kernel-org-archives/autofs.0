From: Doug Nazar <nazard@nazar.ca>
Subject: Re: get_proximity() crashes on interfaces with no addresses
Date: Tue, 14 May 2013 05:15:48 -0400
Message-ID: <519200C4.5050909@nazar.ca>
References: <518FB9DC.3000304@nazar.ca>	 <CAEySpB5ugEzVKNpZPy1PR5baeoN-Z1auET0W0M_OoQwSjTPVtA@mail.gmail.com>	 <518FFC16.9090507@nazar.ca> <1368504805.2464.13.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1368504805.2464.13.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: Leonardo Chiquitto <leonardo.lists@gmail.com>, autofs@vger.kernel.org

On 5/14/2013 12:13 AM, Ian Kent wrote:
> Indeed that's probably good to do too. I'd be interested to hear if 
> this patch functions OK with the IFF_UP check in place. In the mean 
> time I'll add the patch to my queue for the next commit.

I've been running it for a day on a few boxes with no problems. The only 
additional line is a logging line I had when originally testing.

May 14 04:58:47 cockatrice automount[365]: get_proximity:168: 
getifaddrs: ifa_name lo, ifa_flags 0x00010049
May 14 04:58:47 cockatrice automount[365]: get_proximity:168: 
getifaddrs: ifa_name eql, ifa_flags 0x00000400
May 14 04:58:47 cockatrice automount[365]: get_proximity:168: 
getifaddrs: ifa_name eth0, ifa_flags 0x00011043
May 14 04:58:47 cockatrice automount[365]: get_proximity:168: 
getifaddrs: ifa_name wlan0, ifa_flags 0x00001002
May 14 04:58:47 cockatrice automount[365]: get_proximity:168: 
getifaddrs: ifa_name wmon0, ifa_flags 0x00011043

IFF_UP is 0x01 so that looks correct. eql was the one that it was 
crashing on with no ifa_addr.

Doug

